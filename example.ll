; ModuleID = 'example.c'
source_filename = "example.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx14.0.0"

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @random(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 75, ptr %3, align 4
  store i32 74, ptr %4, align 4
  store i32 65537, ptr %5, align 4
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %2, align 4
  %8 = mul i32 %6, %7
  %9 = load i32, ptr %4, align 4
  %10 = add i32 %8, %9
  %11 = load i32, ptr %5, align 4
  %12 = urem i32 %10, %11
  ret i32 %12
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @perfectly_secret(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = xor i32 %3, -17958194
  ret i32 %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @djb2(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 5381, ptr %3, align 4
  %6 = load i32, ptr %2, align 4
  store i32 %6, ptr %5, align 4
  br label %7

7:                                                ; preds = %19, %1
  %8 = load i32, ptr %5, align 4
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %22

10:                                               ; preds = %7
  %11 = load i32, ptr %5, align 4
  %12 = srem i32 %11, 10
  store i32 %12, ptr %4, align 4
  %13 = load i32, ptr %3, align 4
  %14 = shl i32 %13, 5
  %15 = load i32, ptr %3, align 4
  %16 = add i32 %14, %15
  %17 = load i32, ptr %4, align 4
  %18 = add i32 %16, %17
  store i32 %18, ptr %3, align 4
  br label %19

19:                                               ; preds = %10
  %20 = load i32, ptr %5, align 4
  %21 = sdiv i32 %20, 10
  store i32 %21, ptr %5, align 4
  br label %7, !llvm.loop !5

22:                                               ; preds = %7
  %23 = load i32, ptr %3, align 4
  ret i32 %23
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mickens_favorite(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = mul i32 %3, 98
  store i32 %4, ptr %2, align 4
  %5 = load i32, ptr %2, align 4
  %6 = add i32 %5, 105
  store i32 %6, ptr %2, align 4
  %7 = load i32, ptr %2, align 4
  %8 = udiv i32 %7, 116
  store i32 %8, ptr %2, align 4
  %9 = load i32, ptr %2, align 4
  %10 = sub i32 %9, 99
  store i32 %10, ptr %2, align 4
  %11 = load i32, ptr %2, align 4
  %12 = mul i32 %11, 111
  store i32 %12, ptr %2, align 4
  %13 = load i32, ptr %2, align 4
  %14 = add i32 %13, 105
  store i32 %14, ptr %2, align 4
  %15 = load i32, ptr %2, align 4
  %16 = mul i32 %15, 110
  store i32 %16, ptr %2, align 4
  %17 = load i32, ptr %2, align 4
  ret i32 %17
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @aslr(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = add i32 %3, -559038737
  ret i32 %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %55, %0
  %6 = load i32, ptr %3, align 4
  %7 = icmp ult i32 %6, 268435455
  br i1 %7, label %8, label %58

8:                                                ; preds = %5
  %9 = load i32, ptr %2, align 4
  %10 = urem i32 %9, 5
  store i32 %10, ptr %4, align 4
  %11 = load i32, ptr %4, align 4
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %18

13:                                               ; preds = %8
  %14 = load i32, ptr %2, align 4
  %15 = call i32 @random(i32 noundef %14)
  %16 = load i32, ptr %2, align 4
  %17 = add i32 %16, %15
  store i32 %17, ptr %2, align 4
  br label %54

18:                                               ; preds = %8
  %19 = load i32, ptr %4, align 4
  %20 = icmp eq i32 %19, 1
  br i1 %20, label %21, label %26

21:                                               ; preds = %18
  %22 = load i32, ptr %2, align 4
  %23 = call i32 @perfectly_secret(i32 noundef %22)
  %24 = load i32, ptr %2, align 4
  %25 = add i32 %24, %23
  store i32 %25, ptr %2, align 4
  br label %53

26:                                               ; preds = %18
  %27 = load i32, ptr %4, align 4
  %28 = icmp eq i32 %27, 2
  br i1 %28, label %29, label %34

29:                                               ; preds = %26
  %30 = load i32, ptr %2, align 4
  %31 = call i32 @djb2(i32 noundef %30)
  %32 = load i32, ptr %2, align 4
  %33 = add i32 %32, %31
  store i32 %33, ptr %2, align 4
  br label %52

34:                                               ; preds = %26
  %35 = load i32, ptr %4, align 4
  %36 = icmp eq i32 %35, 3
  br i1 %36, label %37, label %42

37:                                               ; preds = %34
  %38 = load i32, ptr %2, align 4
  %39 = call i32 @mickens_favorite(i32 noundef %38)
  %40 = load i32, ptr %2, align 4
  %41 = add i32 %40, %39
  store i32 %41, ptr %2, align 4
  br label %51

42:                                               ; preds = %34
  %43 = load i32, ptr %4, align 4
  %44 = icmp eq i32 %43, 4
  br i1 %44, label %45, label %50

45:                                               ; preds = %42
  %46 = load i32, ptr %2, align 4
  %47 = call i32 @aslr(i32 noundef %46)
  %48 = load i32, ptr %2, align 4
  %49 = add i32 %48, %47
  store i32 %49, ptr %2, align 4
  br label %50

50:                                               ; preds = %45, %42
  br label %51

51:                                               ; preds = %50, %37
  br label %52

52:                                               ; preds = %51, %29
  br label %53

53:                                               ; preds = %52, %21
  br label %54

54:                                               ; preds = %53, %13
  br label %55

55:                                               ; preds = %54
  %56 = load i32, ptr %3, align 4
  %57 = add i32 %56, 1
  store i32 %57, ptr %3, align 4
  br label %5, !llvm.loop !7

58:                                               ; preds = %5
  %59 = load i32, ptr %2, align 4
  ret i32 %59
}

attributes #0 = { noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{!"Homebrew clang version 17.0.6"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
