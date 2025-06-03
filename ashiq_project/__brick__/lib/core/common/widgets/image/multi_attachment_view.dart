import 'package:digigo/core/common/widgets/image/cache_image.dart';
import 'package:digigo/features/visit/presentation/controller/visit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../config/color/custom_color.dart';
import '../../../routes/route_path.dart';

class MultiAttachmentView extends StatelessWidget {
  final List<String> attachmentUrls;
  final void Function(int) onRemoveAt;
  final DecorationImage? image;
  final bool showCloseButton;
  final bool isLoading;

  const MultiAttachmentView(
      {super.key,
      required this.attachmentUrls,
      required this.onRemoveAt,
      this.showCloseButton = true,
      this.isLoading = false,
      this.image});

  @override
  Widget build(BuildContext context) {
    return attachmentUrls.isNotEmpty
        ? Wrap(
            runSpacing: 6,
            spacing: 8,
            children: List.generate(
                attachmentUrls.length,
                (index) => SizedBox(
                      // height: 100,
                       width: 100,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: (){
                              context.pushNamed(Routes.documentViewPage,
                                  extra: {
                                    "type": "Attachment",
                                    "image1": attachmentUrls[index],
                                    "image2": null
                                  });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 12),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black,
                                image: image ??
                                    DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(attachmentUrls[index])),
                              ),
                            ),
                          ),
                          
                          if (showCloseButton)
                            Align(
                                alignment: FractionalOffset.topRight,
                                child: Container(
                                    height: 32,
                                    width: 32,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: isLoading &&
                                            Get.find<VisitController>()
                                                    .selectedIdx
                                                    .value ==
                                                index
                                        ? const CircularProgressIndicator()
                                        : IconButton(
                                            onPressed: () {
                                              onRemoveAt(index);
                                            },
                                            icon: const Icon(
                                              Icons.clear,
                                              color: AppColors.redColor,
                                              size: 18,
                                            ),
                                          )))
                        ],
                      ),
                    )),
          )
        : const SizedBox(height: 0,width: 0,);
  }
}
