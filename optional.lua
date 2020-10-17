dhtPin = 7
button1_Pin = 5
button2_Pin = 6
gpio.mode(button1_Pin, gpio.INT)
gpio.mode(button2_Pin, gpio.INT)
gpio.write(button1_Pin, gpio.LOW)
gpio.write(button2_Pin, gpio.LOW)
pushed = 0

mytimer1_Push = tmr.create()
mytimer2_Push = tmr.create()
--mytimerPush:register(100, 1, function()
mytimer1_Push:alarm(5000, tmr.ALARM_AUTO, function() 
    status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin) 
    if gpio.read(button1_Pin) == 0 then 
       --print("Button1_Pressed")
       if status == dht.OK then
             print(string.format("DHT Temperature:%d.%03d;Humidity:%d.%03d",math.floor(temp),temp_dec,math.floor(humi),humi_dec))
          elseif status == dht.ERROR_CHECKSUM then
             print( "DHT Checksum error." )
          elseif status == dht.ERROR_TIMEOUT then
             print( "DHT timed out." )
          end
    end
end)
mytimer2_Push:alarm(2000, tmr.ALARM_AUTO, function() 
    if gpio.read(button2_Pin) == 1 then 
       --print("Button2_Pressed")
       print("Tempreature & Humidity readings disabled. And You no longer get readings")
    end
end)  

mytimer1_Push:start()
mytimer2_Push:start()

