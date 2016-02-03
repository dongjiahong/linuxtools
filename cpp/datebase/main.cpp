#include "QueryRunner.h"

int main(int argc, char *argv[]) {
	QueryRunner qr("test", "127.0.0.1", "root", "dong123");
	if (qr.query("select * from test;")) {
		mysqlpp::StoreQueryResult res = qr.getQueryResult();
		cout << "res=" << res <<"res.num_rows()="<<res.num_rows()<< endl;
		if (res) {
			for (size_t i=0; i < res.num_rows(); ++i) {
				cout << res[i]["id"] << " "<<
					res[i]["name"] << " "<<
					res[i]["phone"] << endl;
			}
		}
	}
}
