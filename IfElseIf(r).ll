@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @func(i32 %a) {
entry:
  %igualdade = icmp eq i32 %a, 4
  br i1 %igualdade, label %entao_IfElseIF1, label %entao_IfElseIF

entao_IfElseIF1:                                  ; preds = %entry
  ret i32 4

entao_IfElseIF:                                   ; preds = %entry
  %igualdade3 = icmp eq i32 %a, 3
  br i1 %igualdade3, label %entao_ElseIf2, label %senao_ElseIf

entao_ElseIf2:                                    ; preds = %entao_IfElseIF
  ret i32 4

senao_ElseIf:                                     ; preds = %entao_IfElseIF
  %igualdade6 = icmp eq i32 %a, 2
  br i1 %igualdade6, label %entao_ElseIf4, label %senao_ElseIf5

entao_ElseIf4:                                    ; preds = %senao_ElseIf
  ret i32 2

senao_ElseIf5:                                    ; preds = %senao_ElseIf
  %igualdade9 = icmp eq i32 %a, 1
  br i1 %igualdade9, label %entao_ElseIf7, label %senao_ElseIf8

entao_ElseIf7:                                    ; preds = %senao_ElseIf5
  ret i32 1

senao_ElseIf8:                                    ; preds = %senao_ElseIf5
  ret i32 0
}



; Function Attrs: noinline nounwind optnone ssp uwtable
define dso_local i32 @main() #0 {
  %1 = call i32 @func(i32 noundef 4)
  %2 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %1)
  ret i32 0
}


declare i32 @printf(i8* noundef, ...) #1


