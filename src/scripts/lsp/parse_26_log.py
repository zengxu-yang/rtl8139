#!/usr/bin/env python3
import json
import re
import os

def parse_log():
    log_file = "build.log"
    json_file = "compile_commands.json"
    
    if not os.path.exists(log_file):
        print(f"Error: Cannot find {log_file} in the current directory.")
        return

    commands = []
    # Default fallback directory from your Sarge VM screenshot
    current_dir = "/usr/src/kernel-source-2.6.8" 

    # Regex to track directory changes made by make
    dir_enter_re = re.compile(r"make\[\d+\]: Entering directory [`'](.*?)['`]")

    with open(log_file, "r") as f:
        for line in f:
            # 1. Update the current working directory tracking
            m_enter = dir_enter_re.search(line)
            if m_enter:
                current_dir = m_enter.group(1)
                continue
            
            # 2. Break down the chained Kbuild shell commands
            if "gcc " in line and "-c -o" in line:
                parts = line.split(';')
                for part in parts:
                    cmd = part.strip()
                    
                    # Isolate the actual compiler call (ignore the 'echo' part)
                    if cmd.startswith("gcc ") and "-c -o" in cmd:
                        # Find the source file argument (.c file)
                        args = cmd.split()
                        c_files = [a for a in args if a.endswith('.c')]
                        file_path = c_files[0] if c_files else ""
                        
                        commands.append({
                            "directory": current_dir,
                            "command": cmd,
                            "file": file_path
                        })
                        break # Move to the next log line once the real gcc call is caught

    # Write out the clean compilation database
    with open(json_file, "w") as out:
        json.dump(commands, out, indent=2)
        
    print(f"Success! Generated {json_file} with {len(commands)} entries.")

if __name__ == "__main__":
    parse_log()