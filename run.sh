#!/bin/bash
echo "*** !SAG TOO WINDOWS! ***"
OUTPUT_DIRECTORY="out/"
TEST_DIRECTORY="tests/"
REPORT_DIRECTORY="report/"
SOURCE_DIRECTORY="src/"
NUMBER_OF_PASSED=0
NUMBER_OF_FAILED=0
mkdir -p $OUTPUT_DIRECTORY
mkdir -p $REPORT_DIRECTORY
cd ./tests
prefix="t" ;
dirlist=(`ls ${prefix}*.in`) ;
NUMBER_OF_PASSED=0
NUMBER_OF_FAILED=0
cd ../
java -jar lib/jflex-full-1.8.2.jar src/compiler/Scanner/Scanner.flex
java -jar lib/java-cup-11b.jar src/compiler/Parser/parser.cup
mv parser.java sym.java src/compiler/Parser/
javac -cp .:src/:lib/java-cup-11b.jar src/compiler/TesterMain.java
if [ $? -eq 1 ]; then
    echo "Code did not Compiler"
else
    echo "Code compiled successfuly" "$TEST_DIRECTORY$program_code" "$OUTPUT_DIRECTORY$output_asm"
fi
for filelist in ${dirlist[*]}
do
    filename=`echo $filelist | cut -d'.' -f1`;
    output_filename="$filename.out"
    output_asm="$filename.s"
    program_input="$filename.in"
    program_code="$filename.d"
    report_filename="$filename.report.txt"
    echo "Running Test $filename -------------------------------------"
        java -cp .:src/:lib/java-cup-11b.jar compiler.TesterMain -i "$TEST_DIRECTORY$program_code" -o "$OUTPUT_DIRECTORY$output_asm"
        if [ $? -eq 0 ]; then
            echo "MIPS Code Compiled Successfuly!" 
            spim -a -f "$OUTPUT_DIRECTORY$output_asm" < "$TEST_DIRECTORY$program_input" > "$OUTPUT_DIRECTORY$output_filename"
            if [ $? -eq 0 ]; then
                echo "Code Executed Successfuly!"
                tail -n +6 "${OUTPUT_DIRECTORY}${output_filename}" > "${OUTPUT_DIRECTORY}${output_filename}.swp"
                mv "${OUTPUT_DIRECTORY}${output_filename}.swp" "${OUTPUT_DIRECTORY}${output_filename}"
                diff "${OUTPUT_DIRECTORY}${output_filename}" "${TEST_DIRECTORY}${output_filename}" > "${REPORT_DIRECTORY}${report_filename}"
                if [[ $? = 0 ]]; then
                    ((NUMBER_OF_PASSED++))
                    echo "++++ test passed"
                else
                    ((NUMBER_OF_FAILED++))
                    echo "---- test failed !"
                    echo
                fi
            fi
        else
            echo "Code did not execute successfuly!"
            ((NUMBER_OF_FAILED++))
        fi

done

echo "Passed : $NUMBER_OF_PASSED"
echo "Failed : $NUMBER_OF_FAILED"

