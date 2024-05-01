import re
import argparse
import subprocess

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

remove_sections = [
    "_init",
    "plt",
    "got",
    "_fini",
    "stubs",
    "_start",
    "_dl_relocate_static_pie",
    "_dl_relocate_static",
    "deregister_tm_clones",
    "register_tm_clones",
    "_do_global_dtors_aux",
    "frame_dummy",
    "_do_global_ctors_aux",
    "_do_global_dtors_aux",
    "_libc_csu_init",
    "_libc_csu_fini",
    "_libc_start_main",
    "call_gmon_start",
]


def extract_bytes(objdump, output_file, bb_identifiers_file):
    # Remove sections that are not part of the compiled program
    for section in remove_sections:
        # objdump = re.sub("stubs", "", objdump, re.DOTALL)
        objdump = re.sub(section + r"\>:.+?(?:\n\d+\s\<|\Z)", "", objdump, flags=re.DOTALL)
    print(objdump)

    with open(bb_identifiers_file, "r") as bb_identifiers:
        with open(output_file, "w") as out:
            # Extract all basic blocks
            basic_blocks = re.findall(r".+?(?:jmp|ret|>:)", objdump, re.DOTALL)

            prev_hex = []
            # For each block, extract machine code
            for block in basic_blocks:
                hex = []

                # Extract all lines
                x86_lines = re.findall(r"[0-9a-fA-F]+:\s((?:[0-9a-fA-F]{2}\s)+)", block)

                # For each line, extract the hex numbers and put them all in a list
                for line in x86_lines:
                    hex_numbers = line.split()
                    hex += hex_numbers

                if len(hex) == 0 or ("jmp" not in block and "ret" not in block):
                    continue

                hex = prev_hex + hex
                prev_hex = []

                if any(jump in block for jump in conditional_jumps):
                    prev_hex = hex.copy()
                    continue

                bb_identifier = bb_identifiers.readline().strip()

                # Write the basic block identifier
                out.write("\n" + bb_identifier + "\n")

                # Group together 8 bytes and write them in reverse order as a single hexadecimal number
                for i in range(0, len(hex), 8):
                    out.write("0x" + "".join(hex[i : i + 8][::-1]) + "\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Extract machine code from binary executable"
    )
    parser.add_argument(
        "-b", "--binary", type=str, help="Path to binary executable", required=True
    )
    parser.add_argument(
        "-o",
        "--output",
        type=str,
        help="Path to output file",
        required=False,
        default="bytes.txt",
    )
    parser.add_argument(
        "-i",
        "--bb_ids",
        type=str,
        help="Path to basic block identifiers file",
        required=True,
    )
    args = parser.parse_args()
    proc = subprocess.Popen(
        ["objdump", "-d", "-S", args.binary], stdout=subprocess.PIPE
    )
    extract_bytes(proc.stdout.read().decode(), args.output, args.bb_ids)
