def getRsyncProgress(str):
    valueList = str.split(" ")

    valueList = [item for item in valueList if item != ""]

    if len(valueList) < 4:
        return {
            "isProgress": False,
        }
    valueList = valueList[:4]

    if valueList[0].isnumeric() and "%" in valueList[1]:
        return {
            "isProgress": True,
            "bytes": int(valueList[0]),
            "percentage": valueList[1].replace("%", ""),
            "speed": valueList[2],
            "time": valueList[3]
        }
    else:
        return {
            "isProgress": False,
        }