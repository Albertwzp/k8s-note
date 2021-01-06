[TOC]

## Custom Display CRD 
> name：这是我们新增的列的标题，由 kubectl 打印在标题中
> type：要打印的值的数据类型，有效类型为 integer、number、string、boolean 和 date
> JSONPath：这是要打印数据的路径，在我们的例子中，镜像 image 属于 spec 下面的属性，所以我们使用 .spec.image。需要注意的是 JSONPath 属性引用的是生成的 JSON CRD
> description：描述列的可读字符串，目前暂未发现该属性的作用...
> priority: 默认是否显示，可以通过 -o wide来开关
```Go
// +kubebuilder:printcolumn:name="Image",type="string",priority=1,JSONPath=".spec.image",description="The Docker Image of MyAPP
```

[printcolumn](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/#additional-printer-columns)
