# # HOMEWORK: Packages
#
#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__notebooks/08_Packages_Homework.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__notebooks/08_Packages_Homework.ipynb)
#
# Modules and packages are a nice way to organize code. You can read about how
# to deal with packages from the Julia manual
# [Modules](https://pkg.julialang.org/docs/julia/THl1k/1.1.0/manual/modules.html)
# and [Pkg](https://pkg.julialang.org/docs/julia/THl1k/1.1.0/stdlib/Pkg.html#Pkg-1)
# sections and from the
# [package manager documentation.](https://julialang.github.io/Pkg.jl/v1/)
#
# ## PkgTemplates
#
# The quickest and simplest way to create a package is using
# [PkgTemplates](https://github.com/invenia/PkgTemplates.jl). For example,
# this Julia package was generated using the `interactive_template` and
# `generate` functions of `PkgTemplates`.
#
# Also, this package website/documentation and jupyter notebooks are generated
# using [Documenter](https://github.com/JuliaDocs/Documenter.jl)
# and [Literate](https://github.com/fredrikekre/Literate.jl).
#
# #### Homework
#
# Use *PkgTemplates* to create a small *PersonalUtils.jl* package. Include your
# function to read fasta files from the previous homework in your package module
# and add unit tests for it.
#
