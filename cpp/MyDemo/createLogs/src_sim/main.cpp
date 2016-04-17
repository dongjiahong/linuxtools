#include "loadConfig.h"
#include "QueryRunner.h"
#include "struct.h"

using namespace std;

int main() {
    DBINFO db_info{"cpp","localhost","root","dong123"};
    //初始化---
    Log::instance().setLogFileName();
    Config::instance().loadCConfigFromFile();
    Config::instance().showCConfig();
    QueryRunner::instance().initQueryRunner(db_info);
    Log::instance().printLogInfo({"1234567"});
    //---
    size_t row_num=0;
    string sql = "select * from test";
    mysqlpp::StoreQueryResult res = QueryRunner::instance().query(row_num,sql);
    if (row_num) {
        for(size_t i=0;i<row_num;++i) {
            cout << res[i]["id"] << "  "<< res[i]["name"] << endl;
        }
    }
    return 0;
}
