# ctpn-multiclassifier
Multi-Classifier for OCR Text Detection base on CTPN framework

 ctpn-multiclassifier框架是在ctpn框架基础上修改的，实现对图像中文本进行目标检测并实现多分类的升级ctpn模型。
 由于原始ctpn模型是二分类的就是只能分类文字和背景，在有些时候我们需要文本目标检测能够提供初步的文本分类。（例如：单据上的姓名和电话）
 
 原始ctpn模型是基于faster-rcnn开发出来的，代码主题结构与faster-rcnn一致。
 
 ctpn模型是faster-rcnn模型的基础上使用了双向lstm提高了对图像中文字区域的识别准确率。
 
 本模型ctpn-multiclassifier又在ctpn的基础上实现了多分类。做要求训练数据做标注的时候标注出类别。
 
 有相同需求的朋友可以下载代码用比较工具与原ctpn代码进行比较就能理解本模型是如何实现的！
 希望本模型对大家有帮助！
