# # Multiple Sequence Alignments
#
# For this example, we use the Multiple Sequence Alignment (MSA) of the
# *Mu DNA-binding domain*. We use the `downloadpfam` function of the MIToS' Pfam
# module to get the annotated [Stockholm]() file from the [Pfam]() database:

using MIToS.Pfam
pfam_file = downloadpfam("PF02316")

# The `read` function from MIToS' MSA allows to parse multiple sequence
# alignment. The file format is indicated by the second argument. There is
# not need of decompressing the file before reading it:

using MIToS.MSA
msa = read(pfam_file, Stockholm)

# Pfam alignments are generated using [HMMER3]() Hidden Markov Model (HMM)
# searches, have insertion columns (indicated by dots and lowercase letters):

first_seq = sequencenames(msa)[1]

# *TIP:* You can use TranscodingStreams to read compressed files. In particular
# the CodecZlib package has the needed codecs for reading gzipped files.
# For example, the next cell is similar to:
# ```bash
# zgrep ^A0A081B6F8_9RHIZ/19-147 PF02316.stockholm.gz
# ```
# If you are in Linux and you have zgrep installed, you can do:
# ```julia
# run(`zgrep ^$first_seq $pfam_file`)
# ```
# or using the shell mode of the Julia REPL:
# ```julia
# ;zgrep ^$first_seq $pfam_file
# ```

using CodecZlib
open(GzipDecompressorStream, pfam_file) do file
	for line in eachline(file)
		if startswith(line, first_seq)
			println(line)
		end
	end
end

# This columns are deleted by MIToS, therefore the first MSA column is the `"23"` instead of `"1"`

columnnames(msa)[1]

#-

getsequencemapping(msa, 1)



# We can use the MSA function `setreference!` to select one of the sequence
# with known structure as reference (first sequence):
setreference!(msa, "TNPA_BPMU/8-143")
# Then we use `adjustreference!` to remove all the columns with gaps in the
# reference sequence:
adjustreference!(msa)
