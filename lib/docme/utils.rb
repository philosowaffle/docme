#docem utils

def cleanAttribute(attr)
    attr = attr.delete("+[")
    attr = attr.delete("]")
    attr = attr.delete("-")
    return attr
end