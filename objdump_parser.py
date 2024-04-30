import re


conditional_jumps = [
    "jo",
    "jno",
    "js",
    "jns",
    "je",
    "jz",
    "jne",
    "jnz",
    "jb",
    "jnae",
    "jc",
    "jnb",
    "jae",
    "jnc",
    "jbe",
    "jna",
    "ja",
    "jnbe",
    "jl",
    "jnge",
    "jge",
    "jnl",
    "jle",
    "jng",
    "jg",
    "jnle",
    "jp",
    "jpe",
    "jnp",
    "jpo",
    "jcxz",
    "jecxz",
]


def extract_objdump(objdump_file, output_file, bb_identifiers_file):

    with open(objdump_file, "r") as f:
        with open(bb_identifiers_file, "r") as bb_identifiers:
            with open(output_file, "w") as out:
                objdump = f.read()

                # Extract all basic blocks
                basic_blocks = re.findall(r".+?(?:jmp|ret|>:)", objdump, re.DOTALL)

                dont_reset_next = False
                # For each block, extract machine code
                for block in basic_blocks:
                    if dont_reset_next:
                        dont_reset_next = False
                    else:
                        hex = []

                    # Extract all lines
                    x86_lines = re.findall(
                        r"[0-9a-fA-F]+:\s((?:[0-9a-fA-F]{2}\s)+)", block
                    )

                    # For each line, extract the hex numbers and put them all in a list
                    for line in x86_lines:
                        hex_numbers = line.split()
                        hex += hex_numbers

                    if len(hex) == 0 or ("jmp" not in block and "ret" not in block):
                        continue

                    if any(jump in block for jump in conditional_jumps):
                        dont_reset_next = True
                        continue

                    bb_identifier = bb_identifiers.readline().strip()

                    # Write the basic block identifier
                    out.write("\n" + bb_identifier + "\n")

                    # Group together 8 bytes and write them in reverse order as a single hexadecimal number
                    for i in range(0, len(hex), 8):
                        out.write("0x" + "".join(hex[i : i + 8][::-1]) + "\n")


source_objdump_path = "hashinjection/runner-hashlr.txt"
output_bytes_path = "hashinjection/runner-hashlr_bytes.txt"
bb_identifiers_path = "hashinjection/runner-hashlr_bb_identifiers.txt"
extract_objdump(source_objdump_path, output_bytes_path, bb_identifiers_path)
