
define dso_local i32 @main() #0 {
  %1 = call i32 @sum(i32 noundef 1, i32 noundef 2, i32 noundef 3)
  %2 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 noundef %1)
  ret i32 0
}

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
declare i32 @printf(i8* noundef, ...) #1
