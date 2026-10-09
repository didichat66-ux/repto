//@version=5
strategy("Smart Entry/Exit Strategy", overlay=true)

// المدخلات الأساسية
ema_fast_len = input.int(50, title="EMA Fast")
ema_slow_len = input.int(200, title="EMA Slow (Trend)")
rsi_len = input.int(14, title="RSI Length")
rsi_oversold = input.int(30, title="RSI Oversold")
rsi_overbought = input.int(70, title="RSI Overbought")

// حساب المؤشرات
ema_fast = ta.ema(close, ema_fast_len)
ema_slow = ta.ema(close, ema_slow_len)
rsi = ta.rsi(close, rsi_len)
[macdLine, signalLine, histLine] = ta.macd(close, 12, 26, 9)

// شروط الشراء (شراء)
longCondition = close > ema_slow and ta.crossover(rsi, rsi_oversold) and ta.crossover(macdLine, signalLine)

// شروط البيع / الخروج (بيع)
exitCondition = rsi > rsi_overbought or ta.crossunder(macdLine, signalLine) or ta.crossunder(close, ema_fast)

// تنفيذ الصفقات على الشارت
if (longCondition)
    strategy.entry("Buy", strategy.long)

if (exitCondition)
    strategy.close("Buy")

// رسم خطوط المتوسطات على الشارت للمتابعة البصرية
plot(ema_fast, color=color.blue, title="EMA 50")
plot(ema_slow, color=color.orange, title="EMA 200")
