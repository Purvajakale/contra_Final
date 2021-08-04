import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xffFFFDF9),
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          fontSize: 16.0,
          //fontFamily: 'monospace',
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.pinkAccent, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 15),
                    child: Text(
                      'E-Pill Alternative',
                      style:
                          GoogleFonts.solway(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey[800]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 15,top: 10,bottom: 10),
                    child: ReadMoreText(
                      "E-pill is the abbreviation of emergency contraceptive pill.Do not panic if single dose emergency contraceptive pill is not available. After having unprotected intercourse you can use the pack of daily use contraceptive pills (COC) in a different way so as to meet your requirement of emergency contraception.",
                      trimLines: 2,
                      style: GoogleFonts.solway(fontSize: 17, color: Colors.grey[800]),
                      colorClickableText: Colors.grey[400],
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: ' show less',
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5,),
            Card(
              color: Color(0xffFFFDF9),
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.pinkAccent, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 15),
                    child: Text(
                      'COC pills',
                      style:
                          GoogleFonts.solway(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey[800]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 15,top: 10,bottom: 10),
                    child: ReadMoreText(
                      "COC pills can be taken in divided dose at interval of 12 hours. A dose of 100 microgram of ethinyl estradiol with 0.5 mg of Levonorgestrel should be taken twice at interval of 12 hours. You should finish taking both the doses within 72 hours of unprotected sexual intercourse. (Yuzpe method)",
                      trimLines: 2,
                      style: GoogleFonts.solway(fontSize: 17, color: Colors.grey[800]),
                      colorClickableText: Colors.grey[400],
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: ' show less',
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
           SizedBox(height: 5,),
            Card(
              color: Color(0xffFFFDF9),
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.pinkAccent, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 15),
                    child: Text(
                      'YEARLY CHECKUP (COC)',
                      style:
                          GoogleFonts.solway(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey[800]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 15,top: 10,bottom: 10),
                    child: ReadMoreText(
                      "You have to go for medical checkup only once in a year except when you come across a side effect.",
                      trimLines: 2,
                      style: GoogleFonts.solway(fontSize: 17, color: Colors.grey[800]),
                      colorClickableText: Colors.grey[400],
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: ' show less',
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
            // Divider(
            //   color: Colors.transparent,
            //   thickness: 8,
            // ),
            SizedBox(height: 5,),
            Card(
              color: Color(0xffFFFDF9),
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.pinkAccent, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 15),
                    child: Text(
                      'Fertility Return',
                      style:
                          GoogleFonts.solway(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey[800]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 15,top: 10,bottom: 10),
                    child: ReadMoreText(
                      "From all available methods, only male and female sterilization are considered as permanent methods of contraception. Permanent infertility is not caused by any other method of contraception.",
                      trimLines: 2,
                      style: GoogleFonts.solway(fontSize: 17, color: Colors.grey[800]),
                      colorClickableText: Colors.grey[400],
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: ' show less',
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5,),
          
          ],
        ),
      ),
    );
  }
}
