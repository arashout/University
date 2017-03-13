from selenium import webdriver

class LabData(object):
    def __init__(self, trial, location, dbTemp, wbTemp):
    	self.trial = trial
    	self.location = location
        self.dbTemp = dbTemp
        self.wbTemp = wbTemp
        self.W = None
        self.RH = None
        self.specificVolume = None
        self.enthalpy = None

driver = webdriver.Firefox()
driver.get("http://www.sugartech.com/psychro/index.php")
assert("Psychrometric" in driver.title)

lstLabData = []

#Read csv file with lab data
filepath = "lab11Data.csv"
with open(filepath, "r") as f:
	for line in f:
		data = line.rstrip("\n").split(",")
		lstLabData.append(
			LabData(data[0], data[1], data[2], data[3])
			)

for lb in lstLabData:
    #Input data
    dryBulb = driver.find_element_by_name("db")
    dryBulb.clear()
    dryBulb.send_keys(lb.dbTemp)

    wetBulb = driver.find_element_by_name("wb")
    wetBulb.clear()
    wetBulb.send_keys(lb.wbTemp)

    #Press Calculate
    calculateButton = driver.find_element_by_name("calculate")
    calculateButton.click()

    #Read Data and update objects
    elem = driver.find_element_by_name("hum_ratio")
    lb.W = elem.get_attribute("value")

    elem = driver.find_element_by_name("Relat_hum")
    lb.RH = elem.get_attribute("value")

    elem = driver.find_element_by_name("spec_vol")
    lb.specificVolume = elem.get_attribute("value")

    elem = driver.find_element_by_name("enthalpy")
    lb.enthalpy = elem.get_attribute("value")

outputFile = "lab11FullData.csv"
with open(outputFile, "w") as f:
	#Headers
	f.write("Trial,Location,Dry Bulb, Wet Bulb, W, RH, v, h\n")
	for lb in lstLabData:
		f.write("{0},{1},{2},{3},{4},{5},{6},{7}\n".format(
			lb.trial, lb.location, lb.dbTemp, lb.wbTemp,
			lb.W, lb.RH, lb.specificVolume, lb.enthalpy))
