class SliderObject {
  final String background;
  final String image;
  final String? title;

  SliderObject( this.title, this.background, this.image);
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int numberOfSlides;
  final int currentIndex;

  SliderViewObject(this.sliderObject, this.numberOfSlides, this.currentIndex);
}