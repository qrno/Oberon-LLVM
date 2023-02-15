; ModuleID = 'Oberon is Cool B)'
source_filename = "Oberon is Cool B)"

define i32 @func(i32 %a) {
entry:
  %"menor que" = icmp slt i32 %a, 15
  br i1 %"menor que", label %entao1, label %senao

entao1:                                           ; preds = %entry
  ret i32 0

senao:                                            ; preds = %entry
  ret i32 0
}

define i32 @main() {
entry:
  ret i32 0
}
