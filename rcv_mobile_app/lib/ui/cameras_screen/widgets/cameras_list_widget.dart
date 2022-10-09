import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/colors.dart';
import '../cameras_screen_viewmodel.dart';

class CamerasList extends ViewModelWidget<CamerasScreenViewModel> {
  @override
  Widget build(BuildContext context, CamerasScreenViewModel viewModel) {
    return Stack(
      children: <Widget>[
        ListView.builder(
            padding: const EdgeInsets.only(left: 10, right: 10),
            itemCount: viewModel.cameras.length,
            itemBuilder: (BuildContext context, int index) {
              dynamic item = viewModel.cameras[index];
              return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250,
                          margin: const EdgeInsets.only(bottom: 60),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://yandex-images.clstorage.net/5DjV0L235/3c2c1fyMA/-Ukf_3vh1HXW_AdIF4vjvmL-9GE3Ynw9zVBKkoPDwFKm2sop6OmlaL6n3REi96LnB_151N8OkFUE30zEw7N_XZxwWv5Lja1J_vgHRCOvj5p-0tRdF3IsIcQxFv6Ku5h6q96DRLgYCKVbfnTkszMqVv79cKGrAuVgCcehZPY-rhRtWbOfR5lNierkGmTjHxe-tldIHZ8HKKQl_NPWVpOxctcWgr3gSLgp86YEyE8fChpexUxVK5IMnPE_PUE2hjqYPfW_E7uxJRGyIJakzwfT8kILxOHrfxQMHXAz2lKLZZ73imKdKIxkxRPmYAzji5aaBpVc_ScaZPTpNwX5ruKOhFHZU6cvtbltxmROzK_vDyJug_RxN_t0QHkQHzaSOz1-n_4KvVQ4uC1nRliAV4O61nqluNX7OmR8JZf1FUpSXgAVNQsnGzXx9T5wenhbE4v64tfweXMP3KwFuMMGroORJpP68llYKDRhx1YQHP8_BkoWvVidI46cjBGXza3yNgrk9QlXZzOFRRXOQBYQp0sX4kr3AI0Lh3C8dTwP7jqL9SJfOv4NHLxsLVPaTGi7s-I64iGQiR9ytBxVW1mtblJKfPHNX7dLgRWNXvQKxMMzC0byf_z9bztQ2K3wezqmR81aW_5apexUrOlbSqDc00_e3kqFXDFr2jBwDZ85iW6qRty5KfsH740drSog-uwvB7sqIqPQ-YODkJzZyJOi0tMFEpve1jXUuHytHzbIOEsPLv4muezFh8rM3N0nWTEmssKc3Xm3g3ex0cFmQPLQ_8vPilYvkEmbL2AoYdhPqlpDFbInfgqt8OwsSe-2OBRTDzJGDgkcJffCvPwVVzlN4va6tLG9RxOrjS3JoqCapEM_g27uV9QJs4NoPAVcw1Ii04G6GwZOiUx4MIHDOpyMQz--rh6hED1fUrhMVbdRjUYCPhRFRXtPK7XVFXrMrrSnv88yKtOQgcN3ZER97OM-rkcU"),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: Colors.black,
                          ),
                        ),
                        Container(
                            height: 60,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              color: ColorTheme.primaryBg,
                            ),
                            child: Text(item.name,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorTheme.primaryText))),
                        Positioned.fill(
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  splashColor: Colors.grey.withAlpha(30),
                                  onTap: () => viewModel.openCamera(context, index, item.name),
                                ))),
                      ]));
            }),
      ],
    );
  }
}
