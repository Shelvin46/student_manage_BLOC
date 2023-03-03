import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

XFile? imageFile;

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<CameraImage>((event, emit) async {
      XFile? result = await takePhoto(ImageSource.camera);
      return emit(ImagePickerState(image: result));
    });
    on<GalleryImage>((event, emit) async {
      XFile? result = await takePhoto(ImageSource.gallery);
      return emit(ImagePickerState(image: result));
    });
    on<RemoveImage>((event, emit) {
      return emit(ImagePickerState(image: null));
    });
  }
}

Future<XFile?> takePhoto(ImageSource src) async {
  XFile? pickedFile = await ImagePicker().pickImage(source: src);
  var imagefile = pickedFile;
  return imagefile;
}
