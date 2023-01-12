define i32 @sum(i32 %v1, i32 %v2, i32 %v3) {
entry:
  %soma = add i32 %v1, %v2
  %soma1 = add i32 %v3, 3
  %produto = mul i32 %soma, %soma1
  ret i32 %produto
}

define i32 @sum2(i32 %v1, i32 %v2, i32 %v3) {
entry:
  %diferenca = sub i32 %v1, %v2
  %soma = add i32 %v3, 3
  %produto = mul i32 %diferenca, %soma
  ret i32 %produto
}

define dso_local i32 @main() #0 {
  %1 = call i32 @sum(i32 noundef 4, i32 noundef 5, i32 noundef 7)
  %2 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %1)
  ret i32 0
}

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
declare i32 @printf(i8* noundef, ...) #1
