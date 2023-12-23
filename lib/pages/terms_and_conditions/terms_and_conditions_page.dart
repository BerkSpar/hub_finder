import 'package:flutter/material.dart';

/// {@template terms_and_conditions_page}
/// https://www.termsandconditionsgenerator.com/live.php?token=MPcaQCMrlqxZR0jzNQX2gwl413wnZjlx
/// {@endtemplate}
class TermsAndConditionsPage extends StatelessWidget {
  /// {@macro terms_and_conditions_page}
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms and Conditions')),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          Text("""
Welcome to Hub Finder!

These terms and conditions outline the rules and regulations for the use of Berkspar's Website, located at https://api.boomb.io.

By accessing this website, we assume you accept these terms and conditions. Do not continue to use Hub Finder if you do not agree to take all of the terms and conditions stated on this page.

The following terminology applies to these Terms and Conditions, Privacy Statement, and Disclaimer Notice and all Agreements: "Client," "You," and "Your" refer to you, the person logging on this website and compliant to the Company's terms and conditions. "The Company," "Ourselves," "We," "Our," and "Us" refer to our Company. "Party," "Parties," or "Us" refer to both the Client and ourselves. All terms refer to the offer, acceptance, and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client's needs in respect of the provision of the Company's stated services, in accordance with and subject to, prevailing law of br. Any use of the above terminology or other words in the singular, plural, capitalization, and/or he/she or they are taken as interchangeable and therefore as referring to the same.

Cookies

We employ the use of cookies. By accessing Hub Finder, you agreed to use cookies in agreement with Berkspar's Privacy Policy.

Most interactive websites use cookies to let us retrieve the user's details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.

License

Unless otherwise stated, Berkspar and/or its licensors own the intellectual property rights for all material on Hub Finder. All intellectual property rights are reserved. You may access this from Hub Finder for your own personal use subjected to restrictions set in these terms and conditions.

You must not:

- Republish material from Hub Finder
- Sell, rent or sublicense material from Hub Finder
- Reproduce, duplicate, or copy material from Hub Finder
- Redistribute content from Hub Finder

This Agreement shall begin on the date hereof. Our Terms and Conditions were created with the help of the Free Terms and Conditions Generator.

Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Berkspar does not filter, edit, publish, or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of Berkspar, its agents, and/or affiliates. Comments reflect the views and opinions of the person who posts their views and opinions. To the extent permitted by applicable laws, Berkspar shall not be liable for the Comments or for any liability, damages, or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.

Berkspar reserves the right to monitor all Comments and to remove any Comments that can be considered inappropriate, offensive, or cause a breach of these Terms and Conditions.

You warrant and represent that:

- You are entitled to post the Comments on our website and have all necessary licenses and consents to do so;
- The Comments do not invade any intellectual property right, including without limitation copyright, patent, or trademark of any third party;
- The Comments do not contain any defamatory, libelous, offensive, indecent, or otherwise unlawful material which is an invasion of privacy
- The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.

You hereby grant Berkspar a non-exclusive license to use, reproduce, edit, and authorize others to use, reproduce, and edit any of your Comments in any and all forms, formats, or media.

Hyperlinking to our Content

The following organizations may link to our Website without prior written approval:

- Government agencies;
- Search engines;
- News organizations;
- Online directory distributors may link to our Website in the same manner as they hyperlink to the Websites of other listed businesses; and
- System-wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Website.

These organizations may link to our home page, to publications, or to other Website information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement, or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party's site.

We may consider and approve other link requests from the following types of organizations:

- Commonly-known consumer and/or business information sources;
- Dot.com community sites;
- Associations or other groups representing charities;
- Online directory distributors;
- Internet portals;
- Accounting, law, and consulting firms; and
- Educational institutions and trade associations.

We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of Berkspar; and (d) the link is in the context of general resource information.

These organizations may link to our home page so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement, or approval of the linking party and its products or services; and (c) fits within the context of the linking party's site.

If you are one of the organizations listed in paragraph 2 above and are interested in linking to our website, you must inform us by sending an e-mail to Berkspar. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.

Approved organizations may hyperlink to our Website as follows:

- By use of our corporate name; or
- By use of the uniform resource locator being linked to; or
- By use of any other description of our Website being linked to that makes sense within the context and format of content on the linking party's site.

No use of Berkspar's logo or other artwork will be allowed for linking absent a trademark license agreement.

iFrames

Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our Website.

Content Liability

We shall not be held responsible for any content that appears on your Website. You agree to protect and defend us against all claims that are rising on your Website. No link(s) should appear on any Website that may be interpreted as libelous, obscene, or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of any third party rights.

Reservation of Rights

We reserve the right to request that you remove all links or any particular link to our Website. You approve to immediately remove all links to our Website upon request. We also reserve the right to amend these terms and conditions and its linking policy at any time. By continuously linking to our Website, you agree
"""),
        ],
      ),
    );
  }
}
