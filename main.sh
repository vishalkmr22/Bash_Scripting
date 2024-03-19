#!/bin/bash
#PART(1)
# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <output_file>"
    exit 1
fi

input_file="$1"
output_file="$2"

#PART(2)
# Check if input file exists
if [ ! -e "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    exit 1
fi

echo "Input file '$input_file' exists."
echo "Output file will be '$output_file'."

#PART(3)
# Extracting unique cities from input file, sorting them, and saving to output file
awk -F ',' 'BEGIN {print "------------------" } NR > 1 {cities[$3] = 1} END {print "Unique cities in the given data file:"; n = asorti(cities,sorted); for (i = 1;i <= n;i++)print sorted[i];print"------------------"}' "$1" > "$output_file"
echo "Unique cities have been extracted and saved to 'output1.txt'."


{
    #PART(4)
    # Printing the details of top 3 individuals with the highest salary
    awk -F ',' 'BEGIN {print "Details of top 3 individuals with the highest salary:"} {print} NR == 3 {print "------------------"}' <(sort -t ',' -k4,4nr -k1,1 "$1" | head -n 3)

    # Print details of average salary of each city with starting and ending lines
    awk -F ',' 'BEGIN {print "Details of average salary of each city:"} NR > 1 {sum[$3] += $4; count[$3]++} END {for (city in sum) {avg = sum[city] / count[city]; print "City:",city ",", "Average Salary:", avg} print "------------------"}' "$1"
    # echo "Details of average salary of each have been extracted and saved to 'output1.txt'."
    #PART(5)
    # Calculating overall average salary
    overall_avg=$(awk -F ',' 'NR > 1 {sum += $4; count++} END {print sum/count}' "$1")

    #PART(6)
    # Printing the details of individuals with a salary above the overall average salary.
    awk -F ',' -v overall_avg="$overall_avg" 'BEGIN {print "Details of individuals with a salary above the overall average salary:"} NR > 1 && $4 > overall_avg {print $1, $2, $3, $4} END {print "------------------"}' "$1"
} >> "$output_file"
echo "Details of average salary of each have been extracted and saved to 'output1.txt'."
echo "Details of individuals with a salary above the overall average salary have been extracted and saved to 'output1.txt'."