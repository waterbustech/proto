dir=$1

# Check if the directory exists
if [ ! -d "$dir" ]; then
    echo "Directory does not exist!"
    exit 1
fi

# Create or truncate the index.ts file
touch $dir/index.ts
: > $dir/index.ts

# Find all files in the directory
files=$(find $dir -maxdepth 1 -type f )

# Check if the directory is empty
if [ -z "$files" ]; then
    echo "Directory $dir does not contain any files!"
    exit 1
fi

echo "Files found in directory $dir:"

# Loop through each file in the directory
for file in $files
do
    # Check if the file is a TypeScript file and not the index.ts file
    if [[ $file =~ .ts$ && $file != "$dir/index.ts" ]]; then
        echo $file
        filename=$(basename "$file" .ts)
        # Add export statement to index.ts
        echo "export * as $filename from './$filename';" >> $dir/index.ts
    fi
done

# Add export statement for the 'packages' directory to src/interfaces/index.ts
echo "export * from './packages';" >> src/interfaces/index.ts

# Truncate src/index.ts
:> src/index.ts

# Add export statements to src/index.ts
echo "export * from './interfaces';" >> src/index.ts
echo "export * from './service';" >> src/index.ts

echo "index.ts file has been successfully created in the $dir directory!"
