--Set up loaders
ctrl = {}
ctrl = require("data.objects.objects")

--Set up data
data = {}
data = ctrl.loadAll()

a = data.proto.childObject:create()
print(a:isTypeOf("Grungis"))
print(a:isTypeOf("baseInterface"))
