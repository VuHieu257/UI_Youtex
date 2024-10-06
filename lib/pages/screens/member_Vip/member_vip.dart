import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_youtex/core/colors/color.dart';

class MemberVip extends StatefulWidget {
  @override
  _MemberVipState createState() => _MemberVipState();
}

class _MemberVipState extends State<MemberVip>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedPlan = "12 Months Trial";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Gói Hội Viên YOUTEXT",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.roboto(
            fontSize: 16,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: "VIP"),
            Tab(text: "Premium"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildPlanContent("VIP"),
          buildPlanContent("Premium"),
        ],
      ),
    );
  }

  Widget buildPlanContent(String planType) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$planType Plans",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Upgrade or downgrade your plan with ease",
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Plans
            buildPlanCard(
              "12 Months",
              "7 days free trial",
              "55,99 € billed annually after trial",
              "4,67 €/month",
              planValue: "12 Months Trial",
            ),
            buildPlanCard(
              "12 Months",
              "BEST VALUE",
              "43,99 € billed annually",
              "3,67 €/month",
              badgeColor: Colors.blue,
              planValue: "12 Months Standard",
            ),
            buildPlanCard(
              "3 Months",
              "",
              "23,49 € billed every 3 months",
              "7,83 €/month",
              planValue: "3 Months",
            ),
            SizedBox(height: 20),
            // Subscribe Button (giữ nguyên)
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Subscribe Now",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Styles.light,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // What you'll get with PRO (giữ nguyên)
            buildProFeaturesSection(),
          ],
        ),
      ),
    );
  }

  Widget buildPlanCard(String title, String badge, String billing, String price,
      {Color badgeColor = Colors.orange, required String planValue}) {
    bool isSelected = selectedPlan == planValue;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPlan = planValue;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            margin: EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: badge.isNotEmpty ? 10 : 0),
                          Text(
                            title,
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            billing,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      price,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (badge.isNotEmpty)
            Positioned(
              top: -10,
              left: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildProFeaturesSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "WHAT YOU'LL GET WITH PRO",
            style: GoogleFonts.roboto(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          buildProFeatureItem("Unlimited swipes"),
          buildProFeatureItem("Get paid projects by listing your services"),
          buildProFeatureItem("Revamp your profile with more videos & tracks"),
          buildProFeatureItem("Advanced search features"),
          buildProFeatureItem("Keep 100% of royalties with Distribution"),
          buildProFeatureItem("+ All Pro features"),
        ],
      ),
    );
  }

  Widget buildProFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              feature,
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
