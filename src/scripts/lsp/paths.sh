# 1. Fix the working directory path
sed -i 's|/usr/src/kernel-source-2.6.8|/home/zengxu/Projects/kernel-source-2.6.8|g' compile_commands.json

# 2. Fix the source file and compiler output paths
sed -i 's|/home/zengxu/rtl8139|/home/zengxu/Projects/rtl8139/src/ch03|g' compile_commands.json

# 3. Force the relative kernel include flags to be absolute host paths
sed -i 's|-Iinclude|-I/home/zengxu/Projects/kernel-source-2.6.8/include|g' compile_commands.json
