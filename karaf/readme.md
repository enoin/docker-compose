
docker exec -it karaf client

exit from console: control + d



---

service:jmx:rmi:///jndi/rmi://localhost:1099/karaf-root

set user and password, and check "Do not require ssl connection"


java -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.rmi.port=1099 -Djava.rmi.server.hostname=localhost -Djava.net.preferIPv4Stack=true -jar sinplejar.jar


service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi


---


important karaf commands


view karaf version
    version


    features:--


list contained classes
    classes bundleID


 bundle:diag bundleID


package:exports
package:imports

package:exports | grep org.osgi.framework


bundle:tree-show 169
bundle:headers 169



feature:repo-add mvn:<groupId>/<artifactId>/<version>/xml




#### maven repo

feature:install maven

maven:summary -s
maven:repository-list


maven:repository-add --default -id host.local.repository -idx 3 --snapshots -up always '${karaf.home}/host-local-repository'
maven:repository-add --default -id host.local.repository.2 -idx 0 --snapshots -up always '${karaf.home}/host-local-repository/repository'


bundle:install mvn:com.test.bundle/karaf-bundle/4.3.7

    <groupId>com.test.bundle</groupId>
    <artifactId>karaf-bundle</artifactId>
    <version>4.3.7</version>
