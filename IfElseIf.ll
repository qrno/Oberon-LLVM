@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable


define i32 @func(i32 %a) {
entry:
  %igualdade = icmp eq i32 %a, 4
  br i1 %igualdade, label %entao1, label %senao

entao1:                                           ; preds = %entry
  ret i32 4

senao:                                            ; preds = %entry
  %igualdade4 = icmp eq i32 %a, 3
  br i1 %igualdade4, label %entao2, label %senao3

entao2:                                           ; preds = %senao
  ret i32 4

senao3:                                           ; preds = %senao
  %igualdade7 = icmp eq i32 %a, 2
  br i1 %igualdade7, label %entao5, label %senao6
  
entao5:                                           ; preds = %entao2
  ret i32 2
  %igualdade10 = icmp eq i32 %a, 1
  br i1 %igualdade10, label %entao8, label %senao9

senao6:                                           ; preds = %entao2

entao8:                                           ; preds = %entao5
  ret i32 1

senao9:                                           ; preds = %entao5
}


; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 {
  %1 = call i32 @iff(i32 noundef 7)
  %2 = call i32 (i8*, ...) @printf(i8* noundef @.str, i32 noundef %1)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

