; ModuleID = 'Oberon is Cool B)'
source_filename = "Oberon is Cool B)"

declare void @write_integer(i32)

declare i32 @read_integer()

define i32 @func(i32 %x, i32 %y, i32 %z, i32 %k) {
entry:
  %k4 = alloca i32, align 4
  %z3 = alloca i32, align 4
  %y2 = alloca i32, align 4
  %x1 = alloca i32, align 4
  store i32 %x, i32* %x1, align 4
  store i32 %y, i32* %y2, align 4
  store i32 %z, i32* %z3, align 4
  store i32 %k, i32* %k4, align 4
  store i32 0, i32* %x1, align 4
  br label %loop

loop:                                             ; preds = %afterloop, %entry
  %x5 = load i32, i32* %x1, align 4
  call void @write_integer(i32 %x5)
  store i32 0, i32* %z3, align 4
  br label %loop6

loop6:                                            ; preds = %loop6, %loop
  %z7 = load i32, i32* %z3, align 4
  %x8 = load i32, i32* %x1, align 4
  %soma = add i32 %z7, %x8
  store i32 %soma, i32* %k4, align 4
  %z9 = load i32, i32* %z3, align 4
  %soma10 = add i32 %z9, 1
  store i32 %soma10, i32* %z3, align 4
  %k11 = load i32, i32* %k4, align 4
  call void @write_integer(i32 %k11)
  %z12 = load i32, i32* %z3, align 4
  %"menor que" = icmp slt i32 %z12, 10
  br i1 %"menor que", label %loop6, label %afterloop

afterloop:                                        ; preds = %loop6
  %x13 = load i32, i32* %x1, align 4
  %soma14 = add i32 %x13, 1
  store i32 %soma14, i32* %x1, align 4
  %x15 = load i32, i32* %x1, align 4
  %"menor que16" = icmp slt i32 %x15, 10
  br i1 %"menor que16", label %loop, label %afterloop17

afterloop17:                                      ; preds = %afterloop
  ret i32 0
}

define i32 @main() {
entry:
  %0 = call i32 @func(i32 0, i32 0, i32 0, i32 0)
  ret i32 0
}
