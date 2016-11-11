define(<srcdir>, <<.>>)dnl
define(<C_NAME>, <><$1>)dnl
define(<ELF_STYLE>, <yes>)dnl
define(<TYPE_FUNCTION>, <%function>)dnl
define(<TYPE_PROGBITS>, <%progbits>)dnl
define(<ALIGN_LOG>, <yes>)dnl
define(<ALIGNOF_UINT64_T>, <8>)dnl
define(<W64_ABI>, <no>)dnl
divert(1)
.section .note.GNU-stack,"",TYPE_PROGBITS
divert
