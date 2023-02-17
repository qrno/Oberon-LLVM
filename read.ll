; ModuleID = 'Oberon is Cool B)'
source_filename = "Oberon is Cool B)"

declare void @write_integer(i32)

declare i32 @read_integer()

define i32 @func(i32 %x, i32 %y, i32 %soma) {
entry:
  %soma3 = alloca i32, align 4
  %y2 = alloca i32, align 4
  %x1 = alloca i32, align 4
  store i32 %x, i32* %x1, align 4
  store i32 %y, i32* %y2, align 4
  store i32 %soma, i32* %soma3, align 4
  %0 = call i32 @read_integer()
  store i32 %0, i32* %x1, align 4
  %1 = call i32 @read_integer()
  store i32 %1, i32* %y2, align 4
  %x4 = load i32, i32* %x1, align 4
  %y5 = load i32, i32* %y2, align 4
  %soma6 = add i32 %x4, %y5
  store i32 %soma6, i32* %soma3, align 4
  %soma7 = load i32, i32* %soma3, align 4
  call void @write_integer(i32 %soma7)
  %soma8 = load i32, i32* %soma3, align 4
  ret i32 %soma8
}

define i32 @main() {
entry:
  %0 = call i32 @func(i32 0, i32 0, i32 0)
  call void @write_integer(i32 %0)
  ret i32 0
}
