utils/bbox/make.sh
python setup.py build

easydict-1.9$ python setup.py install

(bbox.bbox)

data$ ln -s VOCdevkit VOCdevkit2007

python ./ctpn/train_net.py


===================
pascal_voc.py:

    self._classes = ('__background__', # always index 0
                         'title', 
                         'id')
VGGnet_train.py:

(self.feed('lstm_o').lstm_fc(512,len(anchor_scales) * 10 * 3, name='rpn_cls_score'))

.spatial_reshape_layer(3, name = 'rpn_cls_score_reshape')



anchor_target_layer_tf.py:


    if not cfg.TRAIN.RPN_CLOBBER_POSITIVES:
        # assign bg labels first so that positive labels can clobber them
        #labels[max_overlaps < cfg.TRAIN.RPN_NEGATIVE_OVERLAP] = 0#先给背景上标签，小于0.3overlap的
        labels[:] = 0
    labels[gt_argmax_overlaps] = gt_boxes[:,4] # 1 #每个位置上的9个anchor中overlap最大的认为是前景

    #labels[max_overlaps >= cfg.TRAIN.RPN_POSITIVE_OVERLAP] = 1#overlap大于0.7的认为是前景

network:
    rpn_cls_score = tf.reshape(self.get_output('rpn_cls_score_reshape'), [-1, 3])  # shape (HxWxA, 3)

            rpn_roises = []
            rpn_targetses = []
            for class1 in range(1,3):
                blob,bbox_delta = tf.py_func(proposal_layer_py,[input[0],input[1],input[2], cfg_key, class1, _feat_stride, anchor_scales],\
                                     [tf.float32,tf.float32])
                #pdb.set_trace()
                rpn_rois = tf.convert_to_tensor(tf.reshape(blob,[-1, 5]), name = 'rpn_rois') # shape is (1 x H x W x A, 2)
                rpn_targets = tf.convert_to_tensor(bbox_delta, name = 'rpn_targets') # shape is (1 x H x W x A, 4)
                rpn_roises.append(rpn_rois)
                rpn_targetses.append(rpn_targets)

            self.layers['rpn_rois'] = rpn_roises
            self.layers['rpn_targets'] = rpn_targetses
            return rpn_roises, rpn_targetses


VGGnet_test.py:

(self.feed('lstm_o').lstm_fc(512, len(anchor_scales) * 10 * 3, name='rpn_cls_score'))

.spatial_reshape_layer(3, name='rpn_cls_score_reshape')

.spatial_reshape_layer(len(anchor_scales) * 10 * 3, name='rpn_cls_prob_reshape'))


proposal_layer_tf.py:

scores = np.reshape(np.reshape(rpn_cls_prob_reshape, [1, height, width, _num_anchors, 3])[:,:,:,:,class1],


test.py:

    scoreses = []
    boxeses = []
    for idx in range(2):
        rois = sess.run([net.get_output('rois')[0][idx]], feed_dict=feed_dict)
        rois = rois[0]

        scores = rois[:, 0]
        if cfg.TEST.HAS_RPN:
            assert len(im_scales) == 1, "Only single-image batch implemented"
            boxes = rois[:, 1:5] / im_scales[0]
        scoreses.append(scores)
        boxeses.append(boxes)

    return scoreses,boxeses

demo.py:
with open('data/results/' + 'res_{}.txt'.format(base_name), 'w') as f:














