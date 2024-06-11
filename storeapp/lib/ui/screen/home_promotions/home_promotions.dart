import 'package:atomicdesign/domain/model/promotion_ui_model.dart';
import 'package:flutter/material.dart';

class HomePromotions {

  final promotionItems = [
              PromotionUiModel(flagStr: '99.99%', imgWidget: Image.network('https://picsum.photos/id/292/300/300')),
              PromotionUiModel(flagStr: '20%', imgWidget: Image.network('https://picsum.photos/id/293/300/300')),
              PromotionUiModel(flagStr: '30%', imgWidget: Image.network('https://picsum.photos/id/294/300/300')),
              PromotionUiModel(flagStr: '40%', imgWidget: Image.network('https://picsum.photos/id/295/300/300')),
              PromotionUiModel(flagStr: '50%', imgWidget: Image.network('https://picsum.photos/id/296/300/300')),
            ];

  final bigPromotionItems = [
              PromotionUiModel(flagStr: 'Product 1', imgWidget: Image.network('https://picsum.photos/id/201/300/300')),
              PromotionUiModel(flagStr: 'Product 2', imgWidget: Image.network('https://picsum.photos/id/202/300/300')),
              PromotionUiModel(flagStr: 'Product 3', imgWidget: Image.network('https://picsum.photos/id/203/300/300')),
              PromotionUiModel(flagStr: 'Product 4', imgWidget: Image.network('https://picsum.photos/id/204/300/300')),
              PromotionUiModel(flagStr: 'Product 5', imgWidget: Image.network('https://picsum.photos/id/200/300/300')),
              ];

}