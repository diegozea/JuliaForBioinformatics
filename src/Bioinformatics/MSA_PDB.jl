# # MSA and structures
#
# For this example, we use the Multiple Sequence Alignment (MSA) of the
# *Mu DNA-binding domain*.

using MIToS.Pfam
using MIToS.MSA

const pfam_file = downloadpfam("PF02316")
const msa = read(pfam_file,
				 Stockholm,
				 generatemapping=true,
				 useidcoordinates=true)
