dhtPin = 2
buttonPin = 7
buttonPin2 = 8
gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.LOW)
gpio.mode(buttonPin2, gpio.INPUT)
gpio.write(buttonPin2, gpio.LOW)
pushed = 0

--mytimerPush:register(100, 1, function()
--status, temp, humi, temp_dec, humi_dec = dht.read(dht_pin)

mytimerPush = tmr.create()
--while(1)
--do
--mytimerPush:alarm(5000, tmr.ALARM_AUTO, function() 
--    status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin) 
--    if gpio.read(buttonPin)==1 and pushed then 
--        pushed = 1
--        print("Button detected")
--        if status == dht.OK then
--        print("DHT Temperature:"..temp..";".."Humidity:"..humi)
--    elseif status == dht.ERROR_CHECKSUM then
--        print( "DHT Checksum error." )
--    elseif status == dht.ERROR_TIMEOUT then
--        print( "DHT timed out." )
--    end
--    end  
--end)

--mytimerPush:start()

while(1)
do
  mytimerPush:alarm(300, tmr.ALARM_AUTO, function()
      status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin) 
      if gpio.read(buttonPin)==1 and pushed then 
          pushed = 1
          print("Button detected")
          if status == dht.OK then
          print(string.format("DHT Temperature:%d.%03d;Humidity:%d.%03d",math.floor(temp),temp_dec,math.floor(humi),humi_dec))
      elseif status == dht.ERROR_CHECKSUM then
          print( "DHT Checksum error." )
      elseif status == dht.ERROR_TIMEOUT then
          print( "DHT timed out." )
      end
      end  
  end)
  mytimerPush:alarm(2000, tmr.ALARM_AUTO, function() 
      status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin) 
      if gpio.read(buttonPin2)==1 and pushed then 
          pushed = 1
          print("Button detected")
          print("Tempreature & Humidity readings disabled. And You no longer get readings")
      end  
  end)
  mytimerPush:start()
  tmr.delay(1000000)
end