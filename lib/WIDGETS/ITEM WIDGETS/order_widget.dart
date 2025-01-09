import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/MODELS/order_model.dart';
import 'package:smart_shop/SIDE%20SCREENS/RatingScreen.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key, required this.orderModelAdvanced});
  final OrderModelAdvanced orderModelAdvanced;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool seemore = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getdate(String input) {
      DateTime parsedDate = DateTime.parse(input);
      String formattedDate =
          DateFormat.MMMd().format(parsedDate); // Formats as "Dec 30"
      String year =
          DateFormat.y().format(parsedDate); // Extracts the year as "2023"

      String finalFormattedDate = '$formattedDate $year'; // Combines both parts

      return finalFormattedDate; // Output: Dec 30 2023
    }

    return Column(
      children: [
        FittedBox(
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.width * 0.3,
                    width: size.width * 0.3,
                    child: FancyShimmerImage(
                      imageUrl: widget.orderModelAdvanced.ImageUrl,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.8,
                              child: TitlesTextWidget(
                                label: widget.orderModelAdvanced.prductTitle,
                                maxLines: 2,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SubtitleTextWidget(
                          label: "AED ${widget.orderModelAdvanced.price}",
                          fontSize: 15,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SubtitleTextWidget(
                          label: "Qty : x ${widget.orderModelAdvanced.quntity}",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SubtitleTextWidget(
                          label:
                              "Order Date : ${widget.orderModelAdvanced.orderDate.toDate().day} / ${widget.orderModelAdvanced.orderDate.toDate().month} / ${widget.orderModelAdvanced.orderDate.toDate().year}",
                          color: const Color.fromARGB(255, 138, 106, 9),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  seemore = !seemore;
                });
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: const SubtitleTextWidget(
                  color: AppColors.goldenColor,
                  label: "See more..",
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 20, 0),
              child: SubtitleTextWidget(
                color: AppColors.goldenColor,
                label: widget.orderModelAdvanced.orderStatus == "1"
                    ? "Shipping"
                    : widget.orderModelAdvanced.orderStatus == "2" ||
                            widget.orderModelAdvanced.orderStatus == "3"
                        ? "Delivered"
                        : "Preparing",
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        seemore == true
            ? Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade300,
                    borderRadius: BorderRadius.circular(15)),
                width: size.width * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    //////////////////// Address ////////////////////////
                    // SubtitleTextWidget(
                    //   color: Colors.white,
                    //   label:
                    //       "Address : ${widget.orderModelAdvanced.orderaddress}",
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 13,
                    // ),

                    //////////////////// PAYMRNT METHOD ////////////////////////
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SubtitleTextWidget(
                          label: "Payment Method: ",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        SubtitleTextWidget(
                          color: Colors.white,
                          label: "Cash On Delivery",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SubtitleTextWidget(
                          label: "Delivery Status :  ",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SubtitleTextWidget(
                              color: Colors.white,
                              label:
                                  widget.orderModelAdvanced.orderStatus == "1"
                                      ? "shipping"
                                      : widget.orderModelAdvanced.orderStatus ==
                                                  "2" ||
                                              widget.orderModelAdvanced
                                                      .orderStatus ==
                                                  "3"
                                          ? "Delivered"
                                          : "preparing",
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.orderModelAdvanced.orderStatus == "1"
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SubtitleTextWidget(
                                  label: "Estimated Delivery Date: ",
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.goldenColor,
                                  fontSize: 13,
                                ),
                                SubtitleTextWidget(
                                  label: getdate(widget
                                      .orderModelAdvanced.deliverydate
                                      .toString()),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.goldenColor,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          )
                        : widget.orderModelAdvanced.orderStatus == "2"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RatingScreen(
                                            widget.orderModelAdvanced.orderId,
                                            widget
                                                .orderModelAdvanced.productId)),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: const SubtitleTextWidget(
                                    color: AppColors.goldenColor,
                                    label: "Write Review",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            : widget.orderModelAdvanced.orderStatus == "3"
                                ? Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        SubtitleTextWidget(
                                          color: AppColors.goldenColor,
                                          label:
                                              "Review Added Succesfully , thanks",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
