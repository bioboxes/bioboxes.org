# Bioboxes Assembler Validator

This validator tool is provided to help developers ensure that their short read
assembler biobox matches the specification. You can run the validator image to
test your biobox image, and the output should help you identify any mismatches
between your biobox and the specification.

## Example usage

The use case for the validator is when you have created an assembler biobox and
you would like to ensure it matches the biobox specification. The reason for
doing this is that if your assembler is a valid biobox then anyone already
using biobox assemblers in their bioinformatics pipeline can immediately start
using yours. This is because all bioboxes interface are the same which allows
for simple swapping and replacement of bioformatics tools.

~~~ bash 
# Fetch the latest 0.4.x release of the validator
wget https://s3-us-west-1.amazonaws.com/bioboxes-tools/validate-short-read-assembler/0.4.x/validate-short-read-assembler.tar.gz
tar xzf validate-short-read-assembler.tar.gz

./validate-short-read-assembler/validate bioboxes/velvet default
~~~

This example illustrates using the assembler validator to test the `default`
task of the `bioboxes/velvet` image. The name of the assembler image and the
task to are given as arguments to the validate script. If you would like to
test your own image you only need to replace `bioboxes/velvet` with the name of
the biobox image you are building.

## How the validator works

All the commands and data are needed to test the image are included in inside
the validator package. As long as you can successfully build your image first,
the validator will run a series of scenarios simulating different user
behaviour. The validator then ensures the container gives the expected response
to each. These scenarios [include missing FASTQ files, bad input data, and all
the correct data to produce an assembly][scenarios].

[scenarios]: https://github.com/bioboxes/validator-short-read-assembler/blob/master/src/features/assembler.feature

