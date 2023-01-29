
def get_value(mapp, key):
    '''This function take a dictionary and a string which has the keys to retrieve from the dictionary. Returns the final value or returns None if the value is not found'''
    keys_split = keys.split("/")
    temp = mapp
    for key in keys_split:
        if key in temp:
            temp = temp[key]
        else:
            return None
    return temp

if __name__ == "__main__":
    object = {"x":{"y":{"z":"a"}}} # input dictionary
    # {"a" : {"b" : {"c" : "d"}}}
    keys = "x/y/z" # string with keys
    # "a/b/c"
    print(get_value(object, keys))
