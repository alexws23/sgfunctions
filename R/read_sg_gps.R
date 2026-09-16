#' Read in Sensorgnome GPS Data
#'
#' This function reads the complied .txt file created by the [extract_sg()] function and outputs a data frame with just the Sensorgnome GPS data, which is useful for diagnosing issues.
#' @param x the file name and path of the .txt file you want to read.
#' @param tz specifies which timezone you want the data to output in. A character string. The time zone specification to be used for the conversion, if one is required. System-specific ([`time zones`]), but "" is the current time zone, and "GMT" is UTC (Universal Time, Coordinated). Invalid values are most commonly treated as UTC, on some platforms with a warning. Defaults to "UTC"
#' @export

read_sg_gps <- function(x, tz = "UTC") {

  if (endsWith(x,".txt") == FALSE) {
    stop("Please specify a .txt file")
  }

  lines <- readLines(x)

  # Split each line by comma
  split_lines <- strsplit(lines, ",")

  # Force each row to have exactly 6 columns
  split_fixed <- lapply(split_lines, function(x) {
    length(x) <- 6   # pad with NAs or truncate to length 6
    x
  })


  # Convert to data frame
  data <- as.data.frame(do.call(rbind, split_fixed), stringsAsFactors = FALSE)

  # Keep only gps data
  data <- data[grepl("^G", data$V1), ]

  # Assign column names
  colnames(data) <- c(
      "GPS",
      "time",
      "lat",
      "lon",
      "alt"
    )

  data <- data[, names(data) != "" & !is.na(names(data))]

  # Convert types
  data$time <- as.numeric(data$time)
  data$time <- as.POSIXct(data$time, origin="1970-01-01", tz = "UTC")
  data$time <-  lubridate::with_tz(data$time, tzone = tz)

  return(data)
}
