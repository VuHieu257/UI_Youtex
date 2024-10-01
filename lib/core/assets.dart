import 'dart:ui';

class Asset {
  // ---------------------------------------------------------------------------
  // Images
  // ---------------------------------------------------------------------------
  static const String _img = 'assets/images';
  static const String _icon = 'assets/icon';

  static const String bgLogo = '$_img/logo.png';

  static const String bgSigin = '$_img/img_sigin.png';
  static const String iconFb = '$_img/fb_icon.png';
  static const String iconGg = '$_img/gg_icon.png';
  static const String iconIp = '$_img/ip_icon.png';
  static const String iconCart = '$_icon/icon_cart.png';
  static const String iconMessage = '$_icon/icon_message.png';

  static const String iconVisa = '$_icon/icon_visa.png';
  static const String iconMastercard = '$_icon/icon_mastercard.png';

  static const String bgSlider = '$_img/slider.png';
  static const String bgCardMessage = '$_img/Rectangle 5119.png';
  static const String bgImageProduct = '$_img/home_product.png';
  static const String bgImageCategory = '$_img/category.png';
  static const String bgImageAvatar = '$_img/anh-gai-dep-de-thuong-k7-k8-2k7-2k8_100015595.jpg';



  // ---------------------------------------------------------------------------
  // Shaders
  // ---------------------------------------------------------------------------
  static const String _shaders = 'assets/shaders';
  static const String uiShader = '$_shaders/ui_glitch.frag';
}

// -----------------------------------------------------------------------------
// Fragments
// -----------------------------------------------------------------------------
typedef FragmentPrograms = ({FragmentProgram ui});

Future<FragmentPrograms> loadFragmentPrograms() async =>
    (ui: (await _loadFragmentProgram(Asset.uiShader)),);

Future<FragmentProgram> _loadFragmentProgram(String path) async {
  return (await FragmentProgram.fromAsset(path));
}
