#include "loadConfig.h"
#include <fstream>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>

using namespace std;

//读取配置文件 " adgroup|begin|end|num|flag "
void Config::loadCConfigFromFile() {
    ifstream ifs;
    ifs.open(file_path_.c_str(),ios::in);
    if(!ifs.is_open()) {
        Log::instance().printLogInfo({"Config::loadCConfigFromFile -->文件：",file_path_,"打开失败！"});
        return;
    }
    string str_line;
    while(getline(ifs,str_line)) {
        vector<string> tmpvec;
        boost::split(tmpvec, str_line, boost::is_any_of("|"));
        CCFIG tmpCC;
        tmpCC.adgroup = boost::lexical_cast<long>( tmpvec[0]);
        tmpCC.beginTime = tmpvec[1];
        tmpCC.endTime = tmpvec[2];
        tmpCC.logNum = boost::lexical_cast<int>( tmpvec[3]);
        tmpCC.logType = tmpvec[4];
        cconfig_vector_.push_back(tmpCC);
    }

    ifs.close();
}

void Config::showCConfig() {
    for (const auto &cc : cconfig_vector_) {
        cout << cc.adgroup << "," <<
            cc.beginTime << "," <<
            cc.endTime << "," <<
            cc.logNum << "," <<
            cc.logType << endl;
    }
}

//通过adgroupid获取数据库里相对于的信息
bool Config::getAdgoupInfo(const long& adgroup) {
    string sql = "select adgroup,memberid from jebe_ads.adgroup"; 
    size_t row_num=0;
    mysqlpp::StoreQueryResult res;
    res = QueryRunner::instance().query(row_num, sql);
    if (row_num) {
        
    }

}
