import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'oss_licenses.dart';
import 'util/elbe_ui/elbe.dart';

class OssLicensesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        leadingIcon: LeadingIcon.back(),
        title: 'Open Source Licenses',
        body: ListView.separated(
            padding: const EdgeInsets.all(0),
            itemCount: ossLicenses.length,
            itemBuilder: (context, index) {
              final package = ossLicenses[index];
              return ListTile(
                title: Text('${package.name} ${package.version}'),
                subtitle: package.description.isNotEmpty
                    ? Text(package.description)
                    : null,
                trailing: const Icon(Icons.chevronRight),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MiscOssLicenseSingle(package: package),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider()));
  }
}

class MiscOssLicenseSingle extends StatelessWidget {
  final Package package;

  MiscOssLicenseSingle({required this.package});

  String _bodyText() {
    return package.license!.split('\n').map((line) {
      if (line.startsWith('//')) line = line.substring(2);
      line = line.trim();
      return line;
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      leadingIcon: LeadingIcon.back(),
      title: '${package.name} ${package.version}',
      body: Container(
          child: ListView(children: <Widget>[
        if (package.description.isNotEmpty)
          Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: Text(package.description, style: TypeStyles.bodyL)),
        if (package.homepage != null)
          Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
              child: InkWell(
                child: Text(package.homepage!, variant: TypeVariants.bold),
                onTap: () => launchUrlString(package.homepage!),
              )),
        if (package.description.isNotEmpty || package.homepage != null)
          const Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
          child: Text(_bodyText(), style: TypeStyles.bodyL),
        ),
      ])),
    );
  }
}
