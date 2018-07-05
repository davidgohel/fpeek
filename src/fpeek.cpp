#include <fstream>
#include "R_ext/Riconv.h"
#include <errno.h>
#include <sstream>
#include <Rcpp.h>
#include <string>
using namespace Rcpp;


// read line with either CR, LF or CR LF format
// http://stackoverflow.com/a/6089413/1550314
std::istream& get_line_crlf(std::istream& is, std::string& t)
{
  t.clear();

  std::istream::sentry se(is, true);
  std::streambuf* sb = is.rdbuf();

  for(;;) {
    int c = sb->sbumpc();
    if( c == '\n'){
      return is;
    } else if( c == '\r'){
      if(sb->sgetc() == '\n')
        sb->sbumpc();
      return is;
    } else if( c == std::streambuf::traits_type::eof() ){
      if(t.empty())
        is.setstate(std::ios::eofbit);
      return is;
    } else {
      t += (char)c;
    }
  }
}


// [[Rcpp::export]]
int nlines_(std::string filename, bool with_eof) {
  std::ifstream is(filename.c_str(), std::ifstream::binary);
  int count = 0;
  if( !is )
    stop("error while opening filename");

  std::istream::sentry se(is, true);
  std::streambuf* sb = is.rdbuf();

  for(;;) {
    int c = sb->sbumpc();
    if( c == '\n'){
      count++;
    } else if( c == '\r'){
      if(sb->sgetc() == '\n'){
        sb->sbumpc();
      }
      count++;
    } else if( c == std::streambuf::traits_type::eof() ){
      if(with_eof)
        count++;
      break;
    }
  }

  is.close();
  return count;
}


// [[Rcpp::export]]
std::vector< std::string> head_str_(std::string filename, int n) {
  std::fstream file(filename.c_str(), std::ios::in);
  std::string line;
  int counter = 0;

  std::vector<std::string> out(0);

  if(file.fail()) {
    stop("could not find filename");
  }

  while(!get_line_crlf(file, line).eof()){
    out.push_back(line);
    ++counter;
    if( (counter + 1) > n ) break;
  }
  file.close();

  return out;
}

// [[Rcpp::export]]
void head_print_(std::string filename, int n) {

  std::vector< std::string > head_str = head_str_(filename, n);
  for(size_t i = 0 ; i < head_str.size() ; i++ ){
    Rcout << head_str[i] << "\n";
  }
  return;
}



// [[Rcpp::export]]
std::vector< std::string> tail_str_(std::string filename, int n) {
  std::ifstream is(filename.c_str(), std::ifstream::binary);

  if( !is )
    stop("error while opening filename");

  is.seekg (0, std::ios::end);
  int filesize = is.tellg();
  int size = filesize;
  int match = 0;

  char *c = new char[2];
  int last_isr = 0;
  while (size-- && match <= n) {
    is.seekg (size, std::ios::beg);

    if( is.read(c, 1) ) {
      c[1] = '\0';
      if ( std::strcmp(c, "\n") == 0 ){
        match++;
        last_isr = 1;
      } else if ( std::strcmp(c, "\r") == 0 ){
        if( last_isr < 1 )
          match++;
        last_isr = 0;
      } else {
        last_isr = 0;
      }
    } else break;

  }

  if( match < n ){ // pos to beg bc not enough lines to reach n
    is.seekg (0, std::ios::beg);
  } else {
    // pos to last size value + 2 to match the beg of last n lines
    is.seekg (size-filesize+2, is.end);
  }
  std::vector<std::string> out(0);

  std::string line;
  while(!get_line_crlf(is, line).eof()){
    out.push_back(line);
  }

  is.close();

  return out;
}


// [[Rcpp::export]]
void tail_print_(std::string filename, int n) {
  std::vector< std::string> tail_str = tail_str_(filename, n);
  for(size_t i = 0 ; i < tail_str.size() ; i++ ){
    Rcout << tail_str[i] << "\n";
  }
  return;
}




std::string iconv_str(std::string str, std::string enc_from, std::string enc_to) {

  size_t str_len = str.length();
  size_t str_left = str_len;

  void* iconv_handle = Riconv_open(enc_to.c_str(), enc_from.c_str());

  if (iconv_handle == (void*) -1) {
    if (errno == EINVAL) {
      std::stringstream msg;
      msg << "invalid conversion from " << enc_from << " to " << enc_to;
      stop(msg.str());
    } else {
      stop("error while opening iconv");
    }
  }

  size_t buf_len = str_len * 2;
  std::string buf(buf_len, ' ');
  size_t buf_left = buf_len;

  const char *str_ptr = &str[0];
  char *buf_ptr = &buf[0];

  while (true) {
    size_t res = Riconv(iconv_handle, &str_ptr,
                       &str_left, &buf_ptr,
                       &buf_left);

    if (res == (size_t) -1) {
      if (errno == E2BIG) {
        // enlarge buffer to accomodate the string
        size_t buf_used = buf_len - buf_left;
        buf_left += buf_len;
        buf_len += buf_len;
        buf.resize(buf_len);
        buf_ptr = &buf[buf_used];
      } else {
        stop("error while using iconv");
      }
    } else {
      buf.resize(buf_len - buf_left);
      break;
    }
  }

  if (Riconv_close(iconv_handle) != 0) {
    stop("error while closing iconv");
  }

  return buf;
}

// [[Rcpp::export]]
void file_iconv_(std::string filename, std::string encoding, std::string encto ) {
  std::ifstream is(filename.c_str(), std::ios::in);

  if( !is ){
    stop("error while opening filename");
  }

  std::string line;

  while(!get_line_crlf(is, line).eof()){
    Rcout << iconv_str(line, encoding, encto) << "\n";;
  }
  is.close();
  return ;
}



