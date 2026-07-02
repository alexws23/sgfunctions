#' Read in Sensorgnome GPS Data
#'
#' This function reads the complied .txt file created by the [extract_sg()] function and outputs a data fram with just the Sensorgnome GPS data, which is useful for diagnosing issues.
#' @param x the file name and path of the .txt file you want to read.
#' @param tz specifies which timezone you want the data to output in. A character string. The time zone specification to be used for the conversion, if one is required. System-specific ([`time zones`]), but "" is the current time zone, and "GMT" is UTC (Universal Time, Coordinated). Invalid values are most commonly treated as UTC, on some platforms with a warning. Defaults to "UTC"
#' @export

read_sg_gps <- function(x, tz = "UTC") {

  if (endsWith(x,".txt") == FALSE) {
    stop("Please specify a .txt file")
  }

  # Read data
  data <- utils::read.csv(
    x,
    header = FALSE,
    fill = TRUE,
    stringsAsFactors = FALSE
  )

  if (keep_only_ports == TRUE) {
    # Keep only ports
    data <- data[grepl("^G", data$V1), ]
  }

  colnames(data) <- c(
    "GPS",
    "time",
    "lat",
    "lon",
    "alt"
  )

  # Convert types
  data$time <- as.numeric(data$time)
  data$time <- as.POSIXct(data$time, origin="1970-01-01", tz = "UTC")
  data$time <-  lubridate::with_tz(data$time, tzone = tz)

  return(data)
}
