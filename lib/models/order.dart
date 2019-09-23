class Order {
  int productNumber = 0;
  String productTitle = '';
  double productPrice = 0.0;
  
  save() {
    print({
      productNumber,
      productTitle,
      productPrice
    });
    print('saving user using a web service');
  }
}