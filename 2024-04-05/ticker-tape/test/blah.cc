#include <map>
#include <iostream>
std::map<int, int> map_;

int main()
{
  auto &it = map_.find(1);
  map_[0] = 1;
  std::cout << "it: " << &it << " "
            << "end: " << &map_.end();
  return it == map_.end();
}
// std::string LookUp(std::string key) {
//   auto it = map_.find(key);
//   if (it != map_.end()) {
//     return it.second();
//   }
//   absl::MutexLock lock(mu_);
//   if (it != map_.end()) {
//     return it.second();
//   }
//   map_[key] = SomeNewString();
//   return map[key];
// }