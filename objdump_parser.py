import re

def extract_objdump(source_file_path, output_file_path):
    with open(source_file_path, 'r') as file:
        source_code = file.read()

    pattern = re.compile(
        r'/\*[^*]*\*+(?:[^/*][^*]*\*+)*/',
        re.DOTALL
    )

    potential_matches = pattern.findall(source_code)
    assembly_code = None

    for match in potential_matches:
        # Check if this block contains any lines starting with a hexadecimal address
        if re.search(r'^\s*[0-9a-f]+:\s+', match, re.MULTILINE):
            assembly_code = match
            break

    if assembly_code:
        trimmed_code = re.sub(r'(^\s*/\*|\*/\s*$)', '', assembly_code, flags=re.DOTALL).strip()
        with open(output_file_path, 'w') as output_file:
            output_file.write(trimmed_code)
            print(f"Assembly code written to {output_file_path}")
    else:
        print("No assembly code block found in the source file.")

source_cpp_path = 'hashinjection/injector.cpp'
output_asm_path = 'output_asm.txt'
extract_objdump(source_cpp_path, output_asm_path)
