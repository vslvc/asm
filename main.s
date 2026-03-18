.global main
.data
output_str: .asciz "Y = %lu, remainder = %lu\n"

.text
main:
    # Константы A, B, C (удовлетворяют A^2 >= 3*B^2)
    mov $10, %r8      # A = 5
    mov $2, %r9      # B = 1
    mov $4, %r10     # C = 2

    # Вычисление A^2
    mov %r8, %rax
    mul %r8          # RAX = A^2
    mov %rax, %r11   # сохраняем A^2

    # Вычисление B^2
    mov %r9, %rax
    mul %r9          # RAX = B^2
    mov %rax, %r12   # сохраняем B^2

    # Вычисление 3 * B^2
    mov %r12, %rax
    mov $3, %rcx
    mul %rcx         # RAX = 3 * B^2
    mov %rax, %r12   # теперь r12 = 3 * B^2

    # Числитель |A^2 - 3*B^2| = A^2 - 3*B^2 (положителен)
    mov %r11, %rax
    sub %r12, %rax   # RAX = числитель
    mov %rax, %r13   # сохраняем числитель

    # Вычисление C^3
    mov %r10, %rax
    mul %r10         # RAX = C^2
    mul %r10         # RAX = C^3
    mov %rax, %r14   # сохраняем C^3

    # Деление числителя на C^3 (беззнаковое)
    mov %r13, %rax
    xor %rdx, %rdx   # обнуляем старшую часть делимого
    div %r14         # RAX = частное, RDX = остаток

    # Вывод результата через printf
    lea output_str(%rip), %rdi   # форматная строка
    mov %rax, %rsi                # частное
    # RDX уже содержит остаток (третий аргумент)
    xor %eax, %eax                # количество векторных регистров (0)
    call printf

    # Возврат из main
    xor %eax, %eax
    ret
