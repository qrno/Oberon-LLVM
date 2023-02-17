; ModuleID = 'Oberon is Cool B)'
source_filename = "Oberon is Cool B)"

declare void @write_integer(i32)

declare i32 @read_integer()

define i32 @func(i32 %a, i32 %x) {
entry:
  %x2 = alloca i32, align 4
  %a1 = alloca i32, align 4
  store i32 %a, i32* %a1, align 4
  store i32 %x, i32* %x2, align 4
  %a4 = load i32, i32* %a1, align 4
  %"maior que" = icmp sgt i32 %a4, 4
  br i1 %"maior que", label %entao_IffElse3, label %senao_IfElse

entao_IffElse3:                                   ; preds = %entry
  store i32 4, i32* %x2, align 4
  %x5 = load i32, i32* %x2, align 4
  ret i32 %x5

senao_IfElse:                                     ; preds = %entry
  store i32 2, i32* %x2, align 4
  %x6 = load i32, i32* %x2, align 4
  ret i32 %x6
}

define i32 @main() {
entry:
  ret i32 0
}
