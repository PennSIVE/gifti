#' @title Convert Binary Data Type
#' @description Converts a data type to the size and \code{what} for
#' \code{\link{readBin}}, necessary for \code{Base64Binary} and
#' \code{GZipBase64Binary} formats
#'
#' @param datatype data type from GIFTI image
#'
#' @return List of length 2: with elements of size and what
#' @export
convert_binary_datatype = function(
  datatype = c("NIFTI_TYPE_UINT8",
               "NIFTI_TYPE_INT32",
               "NIFTI_TYPE_UINT32", # this exists but is bad
               "NIFTI_TYPE_FLOAT32")){
  in_data = datatype
  res = try({
    datatype = match.arg(datatype)
  })
  if (inherits(res, "try-error")) {
    stop(paste0("GIFTI datatype is unknown; ",
           "datatype is ", in_data))
  }

  if (datatype %in% c("NIFTI_TYPE_UINT32")) {
    warning(paste0("datatype given is not specified in GIFTI DTD, ",
                   "results may be not correct!"))
  }
  size = switch(datatype,
                NIFTI_TYPE_UINT8 = 1,
                NIFTI_TYPE_INT32 = 4,
                NIFTI_TYPE_UINT32 = 4,
                NIFTI_TYPE_FLOAT32 = 4)
  what = switch(datatype,
                NIFTI_TYPE_UINT8 = integer(),
                NIFTI_TYPE_INT32 = integer(),
                NIFTI_TYPE_UINT32 = integer(),
                NIFTI_TYPE_FLOAT32 = double())
  L = list(size = size, what = what)
  return(L)
}