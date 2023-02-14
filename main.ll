@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define i32 @iff(i32 %a, i32 %b) {
entry:
  %soma = add i32 %a, %b
  %"menor que" = icmp slt i32 %soma, 18
  br i1 %"menor que", label %entao1, label %senao

entao1:                                           ; preds = %entry
  %soma2 = add i32 %a, %b
  ret i32 %soma2

senao:                                            ; preds = %entry
  %diferenca = sub i32 %a, %b
  ret i32 %diferenca
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @main() #0 {
  %1 = call i32 @iff(i32 noundef 12, i32 noundef 15)
  %2 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %1)
  ret i32 0
}

declare i32 @printf(i8* noundef, ...) #1
