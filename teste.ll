@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @iff(i32 %v1) {
entry:
  %"menor que" = icmp slt i32 %v1, 10
  br i1 %"menor que", label %entao1, label %senao

entao1:                                           ; preds = %entry
  ret i32 1

senao:                                            ; preds = %entry
  ret i32 3
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 {
  %1 = call i32 @iff(i32 noundef 7)
  %2 = call i32 (i8*, ...) @printf(i8* noundef @.str, i32 noundef %1)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

